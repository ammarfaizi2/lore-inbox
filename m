Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTKFL6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 06:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTKFL6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 06:58:09 -0500
Received: from ns.schottelius.org ([213.146.113.242]:28846 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S263523AbTKFL6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 06:58:07 -0500
Date: Thu, 6 Nov 2003 12:58:13 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: gadio@netvision.net.il, linux-kernel@vger.kernel.org
Subject: ide-scsi question: 2x
Message-ID: <20031106115813.GF25124@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

1. why is printk used without KERN_* makro?
   like '        printk("[ ");' (267), ide-scsi from 2.6.0test9, version 0.92
   (there are more examples)

2. is the command line hdx=ide-scsi still necessary?
   -> if not, we should update the help
   Can't we pass the options via module parameters (if it is a module) ?
   -> if yes, we should update the help
   -> if no, is it possible to implement it?

Nico
