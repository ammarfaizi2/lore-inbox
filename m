Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWF0Msh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWF0Msh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWF0Msh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:48:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932299AbWF0Msg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:48:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=O0gtuQYQ8RdRyuwpdOC2dx31lrGeXB7dSAdJm0gHlnUFb2hLm/f0LkKeg9e4pYzq0mYTdv5HpvsW+AY0G7WntAAXvO9GdbxY2sJC+EEUk6TS9oOjjVq0dpnGLvUgI8uSQPjzDiJ0woFSvbWQLakcLzTC7cu+pKxjEflB/lE7oaA=
Message-ID: <44A12A30.3020805@innova-card.com>
Date: Tue, 27 Jun 2006 14:53:04 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>, franck.bui-huu@innova-card.com
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Clean up the bootmem allocator
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok here is the clean up broken up into 7 smaller patches.

		Franck

