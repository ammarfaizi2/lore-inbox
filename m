Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWAVR40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWAVR40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWAVR40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:56:26 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:18069 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750940AbWAVR40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:56:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Q8suFV4iML7aqe4KkqWlkdKRX1KSJFvpdQ3xjOmsvrO9XVlWCg5eh3081Br934+TV4mg+Swc/wsq9CtiHbsw6uE6lCtsc7qHhf2uPZrgy+BTb5t7HKYd69eHbp3I1I/6cIByBphkLikIiOGRXhZEvZ4Vw2atnkC9S2QypDrwzA4=
Message-ID: <43D3C616.8070007@gmail.com>
Date: Sun, 22 Jan 2006 18:51:18 +0100
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] minix filesystem: Bug in my patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my former posting in the list

http://marc.theaimsgroup.com/?l=linux-kernel&m=113766834512624&w=2

an important bug has to be corrected, otherwise the number of files is
limited to 65.536 and file corruption can occur.

See the solution in my last post to comp.os.minix:

http://groups.google.com/group/comp.os.minix/browse_thread/thread/2bbdeadd8eab0bd0/49077d297f205c69#49077d297f205c69

I am sorry for the inconvenience.
