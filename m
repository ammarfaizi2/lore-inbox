Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758397AbWK0QyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397AbWK0QyD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758399AbWK0QyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:54:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1758398AbWK0QyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:54:01 -0500
Date: Mon, 27 Nov 2006 16:53:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] LTTng 0.6.36 for 2.6.18 (now with markers)
Message-ID: <20061127165348.GA5348@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>,
	Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com
References: <20061124214831.GA25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124214831.GA25048@Krystal>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're mail suject lines are really bad, they make it totally impossible
to figure out what each patch is about on the mail view folder.

IT should be simply:

Subject: [PATCH n/m] lttng: description
