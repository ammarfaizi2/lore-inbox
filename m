Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263694AbTDDMK5 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 07:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTDDMK4 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 07:10:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26504
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263694AbTDDMHy (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 07:07:54 -0500
Subject: Re: Eric Raymond`s CML2 configuration generator
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030404140410.52717dad.deepfire@ibe.miee.ru>
References: <20030404140410.52717dad.deepfire@ibe.miee.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049455192.2150.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Apr 2003 12:19:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-04 at 11:04, Samium Gromoff wrote:
> 		The question is why the utterly beautiful generator was dropped?

It required a complete mangling of the config files
It didn't include automated tools to do it
It required python2
It didn't support alternative config tools
And a few other things

> 		So what if it was written in C?

It would look something like the Qt and Gtk tools we have, and
improving those is a good thing.

