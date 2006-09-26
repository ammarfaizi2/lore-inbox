Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWIZTEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWIZTEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWIZTEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:04:42 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:30068 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932469AbWIZTEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:04:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Atq6NwnVj94dUxz02OFQ4+KBHwk5HJwT+SVBNMpvRkyu2p0edNTJIuBsNDVpiWrSdmzE5/bH2NSA4CSEXR1iN2H1or3pfDXCbpqI+ZDObO2/4t41fPN+P5JrqtGLC+ad4eq1/Q7+A2DdlPmYtY5Z9b0/RwKuzQMcI4GZIz7TsDA=
Message-ID: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>
Date: Tue, 26 Sep 2006 12:04:40 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Jouni Malinen" <jkmaline@cc.hut.fi>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: 2.6.18-mm1 -- ieee80211: Info elem: parse failed: info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ieee80211: Info elem: parse failed: info_element->len + 2 > left :
info_element->len+2=28 left=9, id=221.
ieee80211: Info elem: parse failed: info_element->len + 2 > left :
info_element->len+2=28 left=9, id=221.
ieee80211: Info elem: parse failed: info_element->len + 2 > left :
info_element->len+2=28 left=9, id=221.

>From dmesg output:
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
