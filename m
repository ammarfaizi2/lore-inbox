Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272066AbTG2Uk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2Uk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:40:57 -0400
Received: from grieg.holmsjoen.com ([206.124.139.154]:30738 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP id S272066AbTG2Ukw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:40:52 -0400
Date: Tue, 29 Jul 2003 13:40:46 -0700
From: Randolph Bentson <bentson@holmsjoen.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030729134046.A8007@grieg.holmsjoen.com>
References: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Tue, Jul 29, 2003 at 09:38:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 09:38:52PM +0100, John Bradford wrote:
> Ah, I just thought, for debugging purposes we could have LEDs for:
> 
> * BKL taken
> * Servicing interrupt
> * Kernel stack usage > 2K

In the way olden days we used the console lights for a realtime
display of buffer use on a PDP-11.  This type of realtime display
can be most useful, especially if it's easily configurable.

-- 
Randolph Bentson
bentson@holmsjoen.com
