Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTJDUfg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbTJDUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:35:36 -0400
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:49588 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262758AbTJDUfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:35:34 -0400
Message-ID: <3F7F2EEB.30808@stesmi.com>
Date: Sat, 04 Oct 2003 22:34:51 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Enrico Bartky <info@realdos.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT600
References: <3F7F1AF1.4000608@realdos.de>
In-Reply-To: <3F7F1AF1.4000608@realdos.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico Bartky wrote:
> Hello,
> 
> I have a new board, the MSI KT6-Delta, with a VIA Apollo KT600 chip set. 
> The southbridge is the VIA VT8237 with S-ATA. But the Kernel can't find 
> any s-ata harddisk?!?
> 
> Can anybody help me?

First of all - what drivers are you trying to run ?

I take it you're running libata and it works for me just fine on my Soyo
SY-KT600 Ultra Platinum Edition board..

// Stefan

