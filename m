Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUFUWGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUFUWGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUFUWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:06:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:63137 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266488AbUFUWGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:06:45 -0400
Subject: Re: BUG?:   G5 not using all available memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40D74EFE.1000500@nortelnetworks.com>
References: <40D74EFE.1000500@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1087855279.22687.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 17:01:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 16:11, Chris Friesen wrote:
> I've got a G5 with 2GB of memory, running 2.6.7, ppc architecture (not ppc64), 
> with the following config options (let me know if others are relevent)

Do you have CONFIG_HIGHMEM enabled ?

Ben.


