Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTKWTn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 14:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTKWTn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 14:43:58 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:46745 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263434AbTKWTn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 14:43:57 -0500
Date: Sun, 23 Nov 2003 19:37:24 +0000
From: Dave Jones <davej@redhat.com>
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DRI and AGP on 2.6.0-test9
Message-ID: <20031123193724.GA24957@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Aubin LaBrosse <arl8778@rit.edu>, linux-kernel@vger.kernel.org
References: <1069571959.9574.46.camel@rain.rh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069571959.9574.46.camel@rain.rh.rit.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > of particular worry to me, though i'm not a kernel hacker, is the line
 > [agp] AGP not available.

Did you modprobe the amd-k7-agp module as well as agpgart ?

		Dave

