Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270808AbTHOUAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270811AbTHOUAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:00:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:20236
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270808AbTHOUAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:00:24 -0400
Date: Fri, 15 Aug 2003 13:00:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: mouschi@wi.rr.com
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: Interesting VM feature?
Message-ID: <20030815200020.GM1027@matchmail.com>
Mail-Followup-To: mouschi@wi.rr.com, Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <147bb3140e7a.140e7a147bb3@rdc-kc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147bb3140e7a.140e7a147bb3@rdc-kc.rr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:56:02PM -0500, mouschi@wi.rr.com wrote:
> Is madvise required to result in zero filled pages
> by a standard, or is this just the commonly accepted
> behavior?

I believe it is the standard for clean pages, though someone else will have
to point out where...
