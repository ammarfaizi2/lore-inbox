Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUCVEVI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUCVEVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:21:08 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:35051 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S261681AbUCVEVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:21:07 -0500
Date: Sun, 21 Mar 2004 23:21:04 -0500 (EST)
From: Abhishek Rai <abba@fsl.cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Subject: put_super for proc
In-Reply-To: <Pine.LNX.4.44.0403212258530.20045-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0403212308440.8761-100000@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to add a put_super for proc as part of some project. Although 
I've done this right, when I unmount proc, it just doesn't call 
proc's put_super. Any clues ?

Thanks in advance!
Abhishek

