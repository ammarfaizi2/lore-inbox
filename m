Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVELTXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVELTXB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVELTXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 15:23:00 -0400
Received: from web53101.mail.yahoo.com ([206.190.39.204]:4191 "HELO
	web53101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261409AbVELTW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 15:22:56 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=rRIWNY4QLxhqauZtCN8nSqYVGrtk4uWeTn+N3jdqZXU4wLZKRF68BrMrg3DGep66/aQ9a2kjHRmkkkEHYODicWwBMZYpplqQvy/CL5KV5Dk2xxAqIi2MfyVAomGRN6ePJIG/v7pLEEs0gbEy4jCqSMrCzpDl4JrZbVFz/2bHBg8=  ;
Message-ID: <20050512192254.43538.qmail@web53101.mail.yahoo.com>
Date: Thu, 12 May 2005 12:22:54 -0700 (PDT)
From: Alan Bryan <icemanind@yahoo.com>
Subject: Enhanced Keyboard Driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Would it be feasable to modify the current keyboard
driver in such a way that it would log the last 1000
keystrokes pushed (possibly log it somewhere in /proc
or something)? When I say keystrokes, I mean
everything...even the ctrl and alt and shift bit keys

Something like this would greatly simplify the program
I am attempting to make.

Thanks

Alan
