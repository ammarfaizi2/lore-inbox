Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265404AbTF3QnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTF3QnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:43:08 -0400
Received: from post.pl ([212.85.96.51]:64269 "HELO matrix01b.home.net.pl")
	by vger.kernel.org with SMTP id S265404AbTF3QnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:43:07 -0400
Message-ID: <3F006C76.7010308@post.pl>
Date: Mon, 30 Jun 2003 18:59:34 +0200
From: "Leonard Milcin Jr." <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net> <bdpn3c$te5$1@tangens.hometree.net>
In-Reply-To: <bdpn3c$te5$1@tangens.hometree.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen wrote:
> "David D. Hagood" <wowbagger@sktc.net> writes:
> 
> 
>>For example, suppose you have a 60G disk, 55G of data, in ext2, and you 
>>wish to convert to ReiserFS.
> 
> 
>>Step 1: Shrink the volume to 55G. This requires a "shrink disk" utility 
>>for the source file system (which exists for the major file systems in 
>>use today).
> 
> 
> You have a 6 GB file. You lose. :-)
> 
> 	Regards
> 		Henning
> 

Hey folk! I don't used LVM, but I think it allows file to be splitted 
between diferent filesystems. Yes?


-- 
"Unix IS user friendly... It's just selective about who its friends are."
                                                        -- Tollef Fog Heen

