Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279838AbRKFROV>; Tue, 6 Nov 2001 12:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279853AbRKFROG>; Tue, 6 Nov 2001 12:14:06 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17495 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279832AbRKFRNQ>; Tue, 6 Nov 2001 12:13:16 -0500
Date: Tue, 6 Nov 2001 12:13:13 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
Message-ID: <20011106121313.B16245@redhat.com>
In-Reply-To: <9s82rl$k51$1@cesium.transmeta.com> <9s9538$23s$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9s9538$23s$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 06, 2001 at 05:02:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 05:02:32PM +0000, Linus Torvalds wrote:
> Which means that the whole approach is just depending on undocumented
> implementation behaviour. That's asking for trouble.

NetWare uses it and has for a long time.

		-ben
