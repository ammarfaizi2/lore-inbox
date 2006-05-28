Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWE1VI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWE1VI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWE1VI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:08:59 -0400
Received: from rune.pobox.com ([208.210.124.79]:37264 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1750930AbWE1VI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:08:59 -0400
Date: Sun, 28 May 2006 14:08:54 -0700
From: Paul Dickson <paul@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bisects that are neither good nor bad
Message-Id: <20060528140854.34ddec2a.paul@permanentmail.com>
In-Reply-To: <20060528140238.2c25a805.dickson@permanentmail.com>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 14:02:38 -0700, Paul Dickson wrote:

> Building and testing a good kernel takes me about 70 minutes.  If I make
> mistakes it can easily take two times (or more!) longer.
>
> I'm currently tracking my work at:
>     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108
>
> I'm currently building my fifth bisect.

Is there a method of bisecting that means neither "good" nor "bad"?  I
have run into kernel problems that are not related to the problem I'm
attempting to track.  Some are not avoidable by changing the .config (see
the third bisect in comments 10 and 11 in the bugzilla report).

	-Paul

