Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTEMUDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTEMUDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:03:32 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:10746 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261950AbTEMUD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:03:29 -0400
Message-ID: <3EC1525F.7020801@nortelnetworks.com>
Date: Tue, 13 May 2003 16:15:27 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
Cc: Daniel Jacobowitz <dan@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
References: <20030512155417.67a9fdec.akpm@digeo.com>	<20030512155511.21fb1652.akpm@digeo.com>	<shswugvjcy9.fsf@charged.uio.no>	<20030513155901.GA26116@nevyn.them.org> <16065.6462.15209.428226@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> Oh. Please also turn off any 'soft' mount option that you may
> have. Like it or not, those *will* cause EIO errors.

Is hard,intr okay from this perspective?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

