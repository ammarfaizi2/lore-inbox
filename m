Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTFPWc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFPWc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:32:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57540 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264376AbTFPWc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:32:27 -0400
Message-ID: <3EEE4880.3080505@us.ibm.com>
Date: Mon, 16 Jun 2003 15:45:20 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: girouard@us.ibm.com, stekloff@us.ibm.com, janiceg@us.ibm.com,
       jgarzik@pobox.com, kenistonj@us.ibm.com, lkessler@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: patch for common networking error messages
References: <OFF1F6B3DC.30C0E5DE-ON85256D47.007AEFAF@us.ibm.com> <20030616.152745.124055059.davem@redhat.com>
In-Reply-To: <20030616.152745.124055059.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Janice Girouard <girouard@us.ibm.com>
>    Date: Mon, 16 Jun 2003 17:29:15 -0500
>    
>    For the sake of consistency and automatic error log analysis, it might be
> 
> And all the scripts checking for the existing messages
> in log files?  Screw them, right?

Are you saying we never get to change any current
log messages ever again on accnt of the scripts that are
monitoring for those precise words? Hope not :)

I'd agree a lot of thought (and agreement :))has to go
into this before changing minor nits and stuff, and not
causing too much disruption..Evolution, as opposed to
revolution ;).  I would hope that most wouldnt need changing..

thanks,
Nivedita



