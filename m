Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVICUxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVICUxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 16:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVICUxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 16:53:41 -0400
Received: from smtp.istop.com ([66.11.167.126]:32960 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751080AbVICUxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 16:53:40 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: GFS, what's remaining
Date: Sat, 3 Sep 2005 16:56:02 -0400
User-Agent: KMail/1.8
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <1125728040.3223.2.camel@laptopd505.fenrus.org> <20050903103503.GB15239@redhat.com>
In-Reply-To: <20050903103503.GB15239@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031656.03418.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 06:35, David Teigland wrote:
> Just a new version, not a big difference.  The ondisk format changed a
> little making it incompatible with the previous versions.  We'd been
> holding out on the format change for a long time and thought now would be
> a sensible time to finally do it.

What exactly was the format change, and for what purpose?
