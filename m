Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSEHPWN>; Wed, 8 May 2002 11:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314465AbSEHPWM>; Wed, 8 May 2002 11:22:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50706 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312426AbSEHPWK>; Wed, 8 May 2002 11:22:10 -0400
Message-Id: <200205081519.g48FJEX24062@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Amol Lad <dal_loma@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
Date: Wed, 8 May 2002 18:23:34 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020508140124.79124.qmail@web12408.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2002 12:01, Amol Lad wrote:
> Hi,
>  Is there any way i can kill a task in
> TASK_UNINTERRUPTIBLE state ?

No. Everytime you see hung task in this state
you see kernel bug.

Somebody correct me if I am wrong.
--
vda
