Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261285AbSIZNu2>; Thu, 26 Sep 2002 09:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSIZNu2>; Thu, 26 Sep 2002 09:50:28 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:20867 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261285AbSIZNu1>; Thu, 26 Sep 2002 09:50:27 -0400
Date: Thu, 26 Sep 2002 14:55:27 +0100
Message-Id: <200209261355.g8QDtRg16986@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 0/7] 2.4.20-pre4/ext3: ext3 minor improvements
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains a couple of minor fixups for ext3 on 2.4, plus
a couple of new checks and functionality aimed at helping InterMezzo.
It also brings the ext3 version up to the current cvs version number.

