Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWAMWic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWAMWic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161577AbWAMWic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:38:32 -0500
Received: from zrtps0kp.nortel.com ([47.140.192.56]:42641 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1161151AbWAMWib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:38:31 -0500
Message-ID: <43C82BD5.2050904@nortel.com>
Date: Fri, 13 Jan 2006 16:38:13 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: "Arne R. van der Heyde" <vanderHeydeAR@summitinstruments.com>,
       linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net
Subject: Re: no carrier when using forcedeth on MSI K8N Neo4-F
References: <43C7F35A.9010703@summitinstruments.com> <20060113222647.GB18972@csclub.uwaterloo.ca>
In-Reply-To: <20060113222647.GB18972@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jan 2006 22:38:15.0567 (UTC) FILETIME=[0B02E9F0:01C61892]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

> Gigabit does NOT use cross over cables.

I don't think this is always true.  Some gigabit ports can autosense 
polarity and are able to use standard cables.  Others require gigabit 
crossover cables.

Chris
