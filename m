Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268716AbUILNX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268716AbUILNX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUILNX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:23:56 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:36554 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S268716AbUILNXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:23:55 -0400
Date: Sun, 12 Sep 2004 17:24:22 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <41446A26.nailNA1I8439@pluto.uni-freiburg.de>
References: <04Sep10.164541edt.6571@ugw.utcc.utoronto.ca>
In-Reply-To: <04Sep10.164541edt.6571@ugw.utcc.utoronto.ca>
User-Agent: nail 11.7pre 9/10/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Siebenmann <cks@utcc.utoronto.ca> wrote:

>  Note that 'cp' is already not POSIX compliant on most Linux systems,
> thanks to GNU libc: 'cp foo -X' ought to work under the POSIX rules I've
> seen, but most Linux systems will have cp helpfully interpret the '-X'
> as a switch (and because it's a bad switch, explode). Evidently strict
> POSIX compatability is not very high on people's priority lists.

This issue is currently discussed on the Austin Group list, but in
contrast to your assumption, there are efforts to get both sides
closer together here, cf.
<http://www.opengroup.org/austin/mailarchives/ag/msg07261.html>.

>  Thus I would expect that the GNU fileutils people would be reasonably
> happy to make cp copy additional file streams and the like by default if
> they actually caught on in Linux.

It is clearly preferred to have such things as extensions that do not
violate the standard.

	Gunnar
