Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbUKPVWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUKPVWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUKPVUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:20:33 -0500
Received: from web51901.mail.yahoo.com ([206.190.39.44]:15456 "HELO
	web51901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261821AbUKPVUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:20:16 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=VW/g40np1oGbNVve4rxjhRNYJkDsxI9DpIUz6jQ6EjsJ8sfKKcXTGZCcNhi2T0qiHvVLtPx3PiLRi4wox+2z2AZEvQ/oO9lk6+bLhQ4+FW8oHCq7479Tqznh+tpqFgTIitZYaOr2TYhEXQXpGYuja++YCUhHd0ZIQC3rLAB8cSI=  ;
Message-ID: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
Date: Tue, 16 Nov 2004 13:20:15 -0800 (PST)
From: A M <alim1993@yahoo.com>
Subject: Accessing program counter registers from within C or Aseembler. 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

Does anybody know how to access the address of the
current executing instruction in C while the program
is executing? 

Also, is there a method to load a program image from
memory not a file (an exec that works with a memory
address)? Mainly I am looking for a method that brings
a program image into memory modify parts of it and
start the in-memory modified version. 

Can anybody think of a method to replace a thread
image without replacing the whole process image? 

Thanks, 

Ali



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

