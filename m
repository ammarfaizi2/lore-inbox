Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUENRCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUENRCn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUENRCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:02:22 -0400
Received: from nrao.edu ([192.33.115.2]:17796 "EHLO cv3.cv.nrao.edu")
	by vger.kernel.org with ESMTP id S261764AbUENQ7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:59:39 -0400
Message-ID: <40A4FAF3.4030103@nrao.edu>
Date: Fri, 14 May 2004 12:59:31 -0400
From: Rodrigo Amestica <ramestic@nrao.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: query_module in 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact postmaster@cv.nrao.edu for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9, required 7,
	autolearn=not spam, BAYES_00 -4.90)
X-MailScanner-From: ramestic@nrao.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

what do you mean by 'You shouldn't need to'? I'm working in a 2.4.x 
platform and discover that I need to check for a module symbol. Then I 
decided that I should do it in such a way that no changes will be 
required at the moment of porting the code to 2.6, and then I came 
across with this thread.

What's the programmatical way of checking for the presence of symbol and 
getting its address?
-
thanks,
 Rodrigo
