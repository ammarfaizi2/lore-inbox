Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTJ3XAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTJ3XAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:00:35 -0500
Received: from main.gmane.org ([80.91.224.249]:10966 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262941AbTJ3XAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:00:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: bd <bdonlan@users.sf.net>
Subject: Re: Post-halloween doc updates.
Date: Thu, 30 Oct 2003 17:16:30 -0500
Organization: Not RoadRunner, that's for sure.
Message-ID: <u6f871-68s.ln1@bd-home-comp.no-ip.org>
References: <20031030141519.GA10700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
X-yzzy: Nothing happens.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> - The format of /proc/stat changed, which could break some
>   applications that still depend on the old layout.
>   Currently the only known application to break is the java
>   'DOTS' app. (http://bugme.osdl.org/show_bug.cgi?id=277)

'xosview' is also broken by this change.

