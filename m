Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUDXToQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUDXToQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 15:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUDXToQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 15:44:16 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9232 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261210AbUDXToP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 15:44:15 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Chris Walker <cwalkatron@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 and 2.4.24 report different memory sizes
Date: Sat, 24 Apr 2004 22:44:04 +0300
User-Agent: KMail/1.5.4
References: <85D529CA.7DFC5911@mail.gmail.com>
In-Reply-To: <85D529CA.7DFC5911@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404242244.04232.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 23:06, Chris Walker wrote:
> I have two identical machines each with 4GB of memory, one running
> 2.4.20 and 2.4.24.
> According to /proc/meminfo (MemTotal):
>
> 2.4.20 : 4138912kB
> 2.4.24 : 3879708kB

Different .config (no HIGHMEM on 2.4.24 one)?
--
vda

