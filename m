Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265359AbSJXJIx>; Thu, 24 Oct 2002 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSJXJIx>; Thu, 24 Oct 2002 05:08:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27396 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265360AbSJXJIw>; Thu, 24 Oct 2002 05:08:52 -0400
Message-Id: <200210240910.g9O9A3p08568@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: harish.vasudeva@amd.com, linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols with RedHat 7.3..
Date: Thu, 24 Oct 2002 12:02:38 -0200
X-Mailer: KMail [version 1.3.2]
References: <CB35231B9D59D311B18600508B0EDF2F04F28758@caexmta9.amd.com>
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F28758@caexmta9.amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 October 2002 16:18, harish.vasudeva@amd.com wrote:
> Hi Folks,
>
>  i have a strange problem with my ethernet driver. On RedHat 7.3
> (2.4.18) i see lot of unresolved symbols (with depmod -a) but on
> RedHat 7.1 (2.4.6) none at all!! what could be the issue?

maybe upgrade modutils.
--
vda
