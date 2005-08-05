Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVHEGJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVHEGJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVHEGIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:08:31 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:5522 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262867AbVHEGI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:08:28 -0400
Message-ID: <42F30252.3080105@davyandbeth.com>
Date: Fri, 05 Aug 2005 01:08:18 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After much research.. I have a question regarding /proc

I have a zombie process which has apparently died for some unknown 
reason.. I know it was terminated by a signal (found that from the 9th 
field (sheduler flags) in /proc/pid/stat)

However, I'm trying to figure out what signal killed it.

Also, it would be nice if /proc could show what the exit status of a 
dead process is.. seems strange that it doesn't contain that information 
(or am I just not seeing it in there).


Any info would be helpful.. thanks,
  Davy


