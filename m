Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTJPAEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 20:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTJPAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 20:04:34 -0400
Received: from h24-77-165-150.wp.shawcable.net ([24.77.165.150]:45195 "EHLO
	boris.borinux.com") by vger.kernel.org with ESMTP id S262574AbTJPAEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 20:04:34 -0400
Date: Wed, 15 Oct 2003 19:03:23 -0500 (CDT)
From: Boris Reisig <boris@boris.ca>
X-X-Sender: boris@boris
To: linux-kernel@vger.kernel.org
Subject: MASQUERADE 2.4.23pre7 problems.
Message-ID: <Pine.LNX.4.58.0310151822320.30845@boris>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the last few 2.4.23pre patches[even the latest 2.4.23pre7], I now
get the following error messages on my console screen and when doing a
dmesg. Here is the error I get when the computers in my lan use the
internet for the first time. [on my server]

MASQUERADE: Route sent us somewhere else.
MASQUERADE: Route sent us somewhere else.
