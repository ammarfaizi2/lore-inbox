Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUJOWUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUJOWUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJOWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:20:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263795AbUJOWUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:20:12 -0400
Date: Fri, 15 Oct 2004 18:20:11 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: ALSA registering controlC0 with no actual card available
Message-ID: <20041015222011.GB6110@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA registers controlC0 for the first card when there is
no card actually available - why?

Bill
