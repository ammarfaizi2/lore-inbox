Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTG1TzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTG1TzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:55:05 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:30731 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270469AbTG1TzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:55:03 -0400
Date: Mon, 28 Jul 2003 20:55:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 999] New: Problem with the /dev/ptmx file
Message-ID: <20030728205501.A26278@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3897970000.1059421161@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3897970000.1059421161@[10.10.2.4]>; from mbligh@aracnet.com on Mon, Jul 28, 2003 at 12:39:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He needs to compile in and use devpts.  But if he insists in the
crappy bugzilla interface instead of lkml I won't tell him.

