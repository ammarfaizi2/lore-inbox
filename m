Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTKDHeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 02:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTKDHeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 02:34:20 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:1986 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263777AbTKDHd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 02:33:59 -0500
Date: Tue, 4 Nov 2003 08:33:59 +0100
From: bert hubert <ahu@ds9a.nl>
To: Shirley Shi <shirley@kasenna.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: All filesystems hang under long periods of heavy load (read and write) on a filesystem
Message-ID: <20031104073359.GB15243@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Shirley Shi <shirley@kasenna.com>, linux-kernel@vger.kernel.org
References: <3FA6E8CE.6040208@kasenna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA6E8CE.6040208@kasenna.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 03:46:22PM -0800, Shirley Shi wrote:
> Can anyone know why all filesystems hang under periods of heavy load on 
> one of the filesystem? Once the filesystems hang, any command related to 
> the filesystem, like 'ls', 'cat',etc., will stick forever until re-power 
> cycling the machine.

I suggest you figure out what your systems have in common, if this were
universal people would've noticed by now. If you have such a hang again, can
you show us the output of 'dmesg' and 'ps aux'? If at all possible, can you
run ShowTasks from the magic SysRQ menu?

Good luck!


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
