Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVKGLnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVKGLnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVKGLnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:43:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47338 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751341AbVKGLnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:43:45 -0500
Date: Mon, 7 Nov 2005 12:43:44 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GIT 0.99.9e
In-Reply-To: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.63.0511071242130.27907@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 6 Nov 2005, Junio C Hamano wrote:

>  - http-push seems to still have a bug or two but that is to be
>    expected for any new code, and I am reasonably sure it can be
>    ironed out; preferably before 1.0 but it is not a
>    showstopper.

I am reasonably sure that a run with valgrind will show the way to a 
stable http-push. It is just a little memory corruption: the rest works 
wonderfully.

Ciao,
Dscho

