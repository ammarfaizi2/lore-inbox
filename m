Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUFGWeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUFGWeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUFGWeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:34:07 -0400
Received: from grex.cyberspace.org ([216.93.104.34]:29959 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP id S265093AbUFGWeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:34:05 -0400
Date: Mon, 7 Jun 2004 18:34:59 -0400
From: Hal Nine <hal9@cyberspace.org>
Message-Id: <200406072234.SAA07853@grex.cyberspace.org>
To: linux-kernel@vger.kernel.org
Subject: Flushing the swap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way of making linux flush out all pages out of swap
space?  I want to have 0K of used swap space.

h9
