Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUE3H4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUE3H4I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 03:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUE3H4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 03:56:08 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:58310 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261206AbUE3H4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 03:56:06 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: Linux 2.6.7-rc2
Date: Sun, 30 May 2004 07:56:05 +0000 (UTC)
Organization: Cistron
Message-ID: <c9c42l$228$1@news.cistron.nl>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
X-Trace: ncc1701.cistron.net 1085903765 2120 62.216.30.38 (30 May 2004 07:56:05 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  <torvalds@osdl.org> wrote:
>Summary of changes from v2.6.7-rc1 to v2.6.7-rc2
>============================================

Ethernet stopped working (for me) going from 2.6.7-rc1-bk3 to 2.6.7-rc2.
AMD64/asusK8V with onboard ethernet.
Dhclient tried to find dhcp server but no response.
Configuration by hand yielded same non-working situation.
Packets where "transmitted" but none received.
2.6.7-rc1-bk3 worked like intended.

Danny

-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

