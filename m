Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTAJKu2>; Fri, 10 Jan 2003 05:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTAJKu2>; Fri, 10 Jan 2003 05:50:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24465
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264844AbTAJKu1>; Fri, 10 Jan 2003 05:50:27 -0500
Subject: Re: Problem:  kernel BUG at page_alloc.c:217!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: t.widjaja1@ugrad.unimelb.edu.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301100825.TAA17664@cassius.its.unimelb.edu.au>
References: <200301100825.TAA17664@cassius.its.unimelb.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042199118.28469.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 11:45:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the Nvidia driver, boot from scratch and duplicate the problem, otherwise since Nvidia
have our source and we don't have theirs only they can help you

