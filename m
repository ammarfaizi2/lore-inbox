Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTFPVR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTFPVR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:17:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63218 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264324AbTFPVRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:17:50 -0400
Subject: Re: Linux 2.5.71 - random console corruption
From: Robert Love <rml@tech9.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Gerhard Mack <gmack@innerfire.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306162226250.26878-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0306162226250.26878-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1055799095.7069.120.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 16 Jun 2003 14:31:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 14:27, James Simmons wrote:

> Preempt and the VT console system are not friends. There are way to many 
> global variables which have there states altered in many spots.

So why is this not an SMP race, too?

	Robert Love

