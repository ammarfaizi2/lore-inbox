Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUCaRCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbUCaRCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:02:53 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53256 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262101AbUCaRCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:02:48 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Subject: Re: rmmod uhci-hcd hangs eternally (linux-2.6.5-rc2-bk8)
Date: Wed, 31 Mar 2004 19:02:39 +0200
User-Agent: KMail/1.5.4
References: <20040331092542.GD28109@charite.de>
In-Reply-To: <20040331092542.GD28109@charite.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403311902.39795.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 11:25, Ralf Hildebrandt wrote:
> Hi!
>
> When using linux-2.6.5-rc2-bk8, "rmmod uhci-hcd" hangs forever. Even

Produce a stacktrace of it: SysRq-T, look into syslog,
cut and mail relevant part.
--
vda

