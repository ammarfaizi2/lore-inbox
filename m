Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUBBOkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 09:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUBBOkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 09:40:52 -0500
Received: from smtp.globe.cz ([81.95.99.120]:18153 "EHLO smtp.globe.cz")
	by vger.kernel.org with ESMTP id S265636AbUBBOku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 09:40:50 -0500
Subject: Re: real-time filesystem monitoring
From: Jan Kokoska <kokoska.jan@globe.cz>
To: linux-kernel@vger.kernel.org, maketo@sdf.lonestar.org
In-Reply-To: <Pine.NEB.4.58.0402021412150.12346@mx.freeshell.org>
References: <Pine.NEB.4.58.0402021412150.12346@mx.freeshell.org>
Content-Type: text/plain
Organization: Globe, a.s.
Message-Id: <1075732847.1674.142.camel@marigold>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 15:40:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 15:19, Ognen Duzlevski wrote:
> Hi,
> 
> I am working on a GPL-ed tool to monitor a filesystem in real time and
> -

Hello,

You can have a look how this has been done elsewhere:

http://www.bangstate.com/changedfiles/

I have tested this here and it works nicely, but you should expect a
higher system load using the userspace daemon for handling file-access
notification actions.

--
 
Jan Kokoska


