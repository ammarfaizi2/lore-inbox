Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbULIAgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbULIAgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbULIAgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:36:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24784 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261391AbULIAgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:36:32 -0500
Message-ID: <41B79DC7.5060209@redhat.com>
Date: Wed, 08 Dec 2004 16:35:19 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Andreas Steinmetz <ast@domdv.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: host name length
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org> <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr> <41B48C9E.6030607@osdl.org> <41B49773.1010006@domdv.de> <41B4B210.1040105@redhat.com> <41B4B2CD.80209@domdv.de> <41B76443.2040205@osdl.org>
In-Reply-To: <41B76443.2040205@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So sethostname(2) sets fqdn, right?

It depends on what people want.  Some people want to use the fqdn.


> Ulrich, do you want help on this or is it already done?

I haven't done any owkr on it an unlikely will get to it anytime soon.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
