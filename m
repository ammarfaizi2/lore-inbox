Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTENMpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTENMo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:44:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262058AbTENMo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:44:58 -0400
Message-ID: <3EC23D3D.3070901@pobox.com>
Date: Wed, 14 May 2003 08:57:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@warthog.cambridge.redhat.com>
CC: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] PAG support, try #2
References: <30949.1052913364@warthog.warthog>
In-Reply-To: <30949.1052913364@warthog.warthog>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
>>We already discussed the coding style issue,
> 
> 
> Well, the coding style is wrong here IMNSHO. Readability is preferable.


Disagree -- using a non-standard style decreases readability simply 
because it's non-standard.

One line of code, one test or operation.  :)

	Jeff



