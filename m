Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTJEVwe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTJEVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:52:34 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:39070
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263879AbTJEVwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:52:34 -0400
Message-ID: <3F809280.3070203@redhat.com>
Date: Sun, 05 Oct 2003 14:52:00 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: POSIX message queues
References: <Pine.GSO.4.58.0310051047560.12323@ultra60> <3F80484A.3030105@redhat.com> <20031005181630.GA26958@mail.shareable.org> <20031005143239.T26086@devserv.devel.redhat.com> <20031005191821.GA27345@mail.shareable.org>
In-Reply-To: <20031005191821.GA27345@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> Why isn't shm_open() simply part of libc?

Because it's defined to be part of librt by POSIX.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

