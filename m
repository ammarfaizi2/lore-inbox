Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTGCSki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbTGCSki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:40:38 -0400
Received: from holomorphy.com ([66.224.33.161]:65217 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265263AbTGCSkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:40:31 -0400
Date: Thu, 3 Jul 2003 11:54:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703185431.GQ26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jamie Lokier <jamie@shareable.org>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030702220246.GS23578@dualathlon.random> <20030702221551.GH26348@holomorphy.com> <20030702222641.GU23578@dualathlon.random> <20030702231122.GI26348@holomorphy.com> <20030702233014.GW23578@dualathlon.random> <20030702235540.GK26348@holomorphy.com> <20030703113144.GY23578@dualathlon.random> <20030703114626.GP26348@holomorphy.com> <20030703125839.GZ23578@dualathlon.random> <20030703184825.GA17090@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703184825.GA17090@mail.jlokier.co.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
>> but I didn't hear any emulator developer ask for this feature yet

On Thu, Jul 03, 2003 at 07:48:25PM +0100, Jamie Lokier wrote:
> No, but there was a meek request to get writable/read-only protection
> working with remap_file_pages, so that a garbage collector can change
> protection on individual pages without requiring O(nr_pages) vmas.
> Perhaps that should have nothing to do with remap_file_pages, though.

I call that application #2.


-- wli
