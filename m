Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUEBWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUEBWMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbUEBWMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 18:12:06 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:35589 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263325AbUEBWMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 18:12:05 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Niel Lambrechts <antispam@absamail.co.za>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.6-rc2-mm1] rmmod processor causes kernel panic on speedstep-centrino
Date: Mon, 3 May 2004 01:11:56 +0300
User-Agent: KMail/1.5.4
References: <1083532317.18059.12.camel@localhost>
In-Reply-To: <1083532317.18059.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405030111.56469.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 May 2004 00:11, Niel Lambrechts wrote:
> EIP:    0060:[<e19db3e6>]    Tainted: PF  VLI
                               ^^^^^^^^^^^
You are using binary only modules. Please ask authors for help.
--
vda

