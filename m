Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272774AbTG3GKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272778AbTG3GKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:10:11 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:25749 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272774AbTG3GKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:10:09 -0400
Date: Wed, 30 Jul 2003 08:09:58 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Eli Carter <eli.carter@inet.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730060958.GH4279@louise.pinerecords.com>
References: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk> <3F26DC68.3010000@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F26DC68.3010000@inet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [eli.carter@inet.com]
> 
> Maybe also:
> ...
>  * and of course, Morse code ;)

Provided the lowlevel LED support is hacked together as a module for
the 2.[56] input layer, the current morse code panics patch should work
"out of the box."

-- 
Tomas Szepe <szepe@pinerecords.com>
