Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVCGEnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVCGEnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 23:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVCGEnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 23:43:49 -0500
Received: from web53302.mail.yahoo.com ([206.190.39.231]:28308 "HELO
	web53302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261548AbVCGEnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 23:43:47 -0500
Message-ID: <20050307044347.79640.qmail@web53302.mail.yahoo.com>
Date: Mon, 7 Mar 2005 04:43:47 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: symlink to proc file
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  dear sir 
i want to create a symbolic link to my own proc file
system (which has been already created in
/fs/proc/root.c)  from the /kernel/fork.c
how to do it 
i actually want to write inside the proc directory
using the syslink 
what will be the syntax and the parameter passed
could you plz explain me the parameters passed 
to 

struct proc_dir_entry* proc_symlink(const char* name,
struct
proc_dir_entry* parent, const char* dest);

thanks 
sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
