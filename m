Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTFDPqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTFDPqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:46:46 -0400
Received: from dan.arc.nasa.gov ([143.232.69.77]:28033 "EHLO rudi.arc.nasa.gov")
	by vger.kernel.org with ESMTP id S263462AbTFDPqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:46:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dan Christian <Daniel.A.Christian@NASA.gov>
Reply-To: Daniel.A.Christian@NASA.gov
Organization: NASA Ames Research Center
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
Date: Wed, 4 Jun 2003 09:00:01 -0700
User-Agent: KMail/1.4.3
References: <200306031728.41982.Daniel.A.Christian@NASA.gov> <200306040232.16281.m.c.p@wolk-project.de>
In-Reply-To: <200306040232.16281.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306040900.01442.Daniel.A.Christian@NASA.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 17:32, Marc-Christian Petersen wrote:
> Just a guess: Did you switch from UP to SMP with out doing "make
> mrproper"?
>
> ciao, Marc

No, I didn't do "make mrproper".  I'll try that.

It used to be that it wasn't needed and it liked to blow away .config 
(an extreme mis-feature if I ever saw one).

Thanks,
-Dan
