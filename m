Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271348AbTGWWI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271355AbTGWWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:08:28 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:59886 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271348AbTGWWI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:08:27 -0400
Subject: Re: 2.6.0-test1-ac3 still broken on Adaptec I2O
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Flory <sflory@rackable.com>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1EFC2F.8040109@rackable.com>
References: <20030723201801.GB32585@rdlg.net>
	 <1058991837.5520.135.camel@dhcp22.swansea.linux.org.uk>
	 <3F1EFC2F.8040109@rackable.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058998652.6890.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 23:17:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 22:20, Samuel Flory wrote:
>   Acording to this bug adaptec isn't planning on doing so.
> http://bugme.osdl.org/show_bug.cgi?id=217

Then I guess it won't be in 2.6.0 and Adaptec will catch up later. 
Depends how they define "stable" and what contracts they have with
whom to maintain it, if any.

Either way someone else can fix it if they want, or use the core
i2o drivers which should drive this hardware nowdays

