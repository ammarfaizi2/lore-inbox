Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVAGA2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVAGA2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVAGAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:25:34 -0500
Received: from web52602.mail.yahoo.com ([206.190.39.140]:51565 "HELO
	web52602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261229AbVAGAXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:23:34 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=qwIbanR6P0sbDvgDpWfYsmtTxbnyGsL4ct5nVgyyAKYDGRxKmVYzOx2i8sVknbzNdgqOym5JnPPavXYG2IacKl+PtuwuBqH/9xq6z8CJoj/Di5WRPMxuOKg/C+I+POa/fmRBI35FUk9mcSASU4pPed/KEQiVDDVFSYlLNq2pQfo=  ;
Message-ID: <20050107002333.21133.qmail@web52602.mail.yahoo.com>
Date: Thu, 6 Jan 2005 16:23:33 -0800 (PST)
From: jesse <jessezx@yahoo.com>
Subject: how to find all threads of a given process?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

suppose I already know the PID of a process, how could
i quickly identify all threads of this process? 

As i know, under /proc, threads of all processes have
prefix ".", one way is to iterate each one and do the
check. the approach is too expensive. any other
suggestions?

for instance, 


