Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTF3P3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTF3P3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:29:30 -0400
Received: from post.pl ([212.85.96.51]:18194 "HELO matrix01b.home.net.pl")
	by vger.kernel.org with SMTP id S264590AbTF3P33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:29:29 -0400
Message-ID: <3F005B34.1090701@post.pl>
Date: Mon, 30 Jun 2003 17:45:56 +0200
From: "Leonard Milcin Jr." <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
References: <200306301411.h5UEB8uL000195@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200306301411.h5UEB8uL000195@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Out of interest, won't the resulting filesystem be excessively
> fragmented, and cause worse performance than a virgin filesystem, or
> does the reiser resizer actively prevent that?

This is not a big problem. Firstly, we have to get a working filesystem, 
whether it will be fragmented or not. Then the filesystem can be 
defragmented.

-- 
"Unix IS user friendly... It's just selective about who its friends are."
                                                        -- Tollef Fog Heen

