Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTKKPFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTKKPFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:05:43 -0500
Received: from emix.uci.agh.edu.pl ([149.156.96.16]:15333 "EHLO
	emix.uci.agh.edu.pl") by vger.kernel.org with ESMTP id S263546AbTKKPFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:05:32 -0500
Date: Tue, 11 Nov 2003 16:05:26 +0100
From: Maciej Freudenheim <fahren@student.uci.agh.edu.pl>
X-Priority: 3 (Normal)
Message-ID: <3877654471.20031111160526@student.uci.agh.edu.pl>
To: Ragnar Hojland Espinosa <ragnar@linalco.com>
Cc: rouquier.p@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re[2]: reiserfs 3.6 problem with test9
In-Reply-To: <20031111135948.GA5229@linalco.com>
References: <1068553197.1018.43.camel@Genesyme>
 <20031111135948.GA5229@linalco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday, November 11, 2003, 2:59:48 PM, Ragnar Hojland Espinosa wrote:

RHE> On Tue, Nov 11, 2003 at 01:19:57PM +0100, Philippe wrote:

>> recently I noticed some annoying problems whenever I try to access some
>> files on my harddrive (reiserfs filesystem). I get "permission denied"

RHE> Last time I had a box with similar problems it was memory.  I'd put
RHE> your system through a memtest.

No, Philippe is right - I've also noticed that "permission denied"
corruption on reiserfs - and I never had such problem(s) earlier
(on 2.4 and older 2.6-test) - so it has to be 2.6.0-test8/test9 fault.
(However, I'm not sure if it started exactly at 2.6.0-test8 :/)


Maciej Freudenheim.

