Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTIKU2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbTIKU2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:28:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:21726 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261510AbTIKU2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:28:36 -0400
Date: Thu, 11 Sep 2003 22:24:04 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Eric Bickle <ebickle@healthspace.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: IDE data corruption with VIA chipsets on 2.4.20-19.8+others
Message-ID: <20030911222404.A1254@electric-eye.fr.zoreil.com>
References: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <003601c37826$26d8d220$5d74ad8e@hyperwolf>; from ebickle@healthspace.ca on Wed, Sep 10, 2003 at 10:32:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Bickle <ebickle@healthspace.ca> :
[...]
> About one week later, the machine started behaving badly. Random crashes,
> problems, etc. A very unstable server. We suspected it was the IDE. We built
> another server using a different brand of motherboard and hard-drives and
> launched the server. One or two weeks later - same thing - major problems,
> crashes. In fact, we've launched about 4 different hardware configurations,
> some raid, some non-raid, different hard-drive brands, different versions of
> Lotus Domino. There is only one thing in common - they all crash, they all
> run RedHat Linux, and they all use IDE.

Overheat ?

What do smartctl -a and sensors output at regular interval say ?

Regards

--
Ueimor
