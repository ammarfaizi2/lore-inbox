Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVKNB0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKNB0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 20:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVKNB0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 20:26:47 -0500
Received: from mailhub2.uq.edu.au ([130.102.149.128]:38668 "EHLO
	mailhub2.uq.edu.au") by vger.kernel.org with ESMTP id S1750824AbVKNB0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 20:26:46 -0500
From: Christian Unger <c.unger@uq.edu.au>
Organization: Unix Server Group
To: linux-kernel@vger.kernel.org
Subject: kjournald - what does this process actually do?
Date: Mon, 14 Nov 2005 11:22:40 +1000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141122.40638.c.unger@uq.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I was wondering, what does kjournald actually do. I know it relates to using 
jounralised file systems such as ext3 and reiserfs, but that's about it. I 
wasn't really hoping to dig through source code, but :P ...

Also, what would cause a kjournald process to go down?

-- 
with kind regards,
                  Christian Unger

 Unix Server & Security - ITS        Email:   c.unger@uq.edu.au
 University of Queensland            Phone:  +61 (0)7 336 57019

 "if [educating users] was going to work, 
  it would have worked by now"
                   (Marcus J. Ranum - on flawed security ideas)
