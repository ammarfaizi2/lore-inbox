Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTDGOvA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTDGOvA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:51:00 -0400
Received: from smtp03.web.de ([217.72.192.158]:43809 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263478AbTDGOu4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:50:56 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Serial port over TCP/IP
Date: Mon, 7 Apr 2003 16:53:33 +0200
User-Agent: KMail/1.5
References: <200304061447.46393.freesoftwaredeveloper@web.de> <b6qoa5$edn$1@cesium.transmeta.com>
In-Reply-To: <b6qoa5$edn$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304071653.33936.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 04:37, H. Peter Anvin wrote:
> I think what you need is the enhanced pty driver patch which was
> posted recently, which made is possible for a user-space process to
> also capture ioctls() such as baud rate setting etc.  Then the rest of
> the work can be done in userspace.

Thanks, this is a good solution!

Regards
Michael Buesch

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

