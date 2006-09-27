Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965375AbWI0GGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbWI0GGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965376AbWI0GGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:06:13 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:401 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965364AbWI0GFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:05:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HBonreHjCenRWONOj7ghlvPC7eSI8piBXxF/Wd+5xdLcnKWim5ZinVQRKBgD4pkN7fzlD95yjcXI1a0tUFG86+4jhSuJDIEwm9zYcG1ZOg2430MaI7OevNgqAHqLJ1nc0yJDJ/0AqmqAvRw9htL2X6fYMEDXQri7n49+ajtvVpA=
Message-ID: <a44ae5cd0609262305p1d0b9aaai9db324aff0b3ba0c@mail.gmail.com>
Date: Tue, 26 Sep 2006 23:05:44 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Jouni Malinen" <jkmaline@cc.hut.fi>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed: info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
In-Reply-To: <a44ae5cd0609261756w1e82087p60c18ef941657466@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>
	 <a44ae5cd0609261756w1e82087p60c18ef941657466@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It occurs to me that these messages occured while I was connected to a
public WIFI AP at the airport in Phoenix.  It may be that the network
configuration or my distance from the AP had a part to play in the
messages being triggered.  If so, I may have trouble reproducing the
problem.  I'll be interested to hear from some of the IEEE80211
developers on what these messages indicate.

ieee80211: Info elem: parse failed: info_element->len + 2 > left :
info_element->len+2=28 left=9, id=221.
ieee80211: Info elem: parse failed: info_element->len + 2 > left :
info_element->len+2=28 left=9, id=221.
ieee80211: Info elem: parse failed: info_element->len + 2 > left :
info_element->len+2=28 left=9, id=221.
