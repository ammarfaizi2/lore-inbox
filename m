Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUGIPGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUGIPGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUGIPGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:06:38 -0400
Received: from opersys.com ([64.40.108.71]:28430 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S264953AbUGIPFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:05:43 -0400
Message-ID: <40EEB311.2090607@opersys.com>
Date: Fri, 09 Jul 2004 11:00:33 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Robert Wisniewski <bob@watson.ibm.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: About the usefulness of kernel tracing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As I noted when discussing this with Andrew, we've been trying to get
LTT into the kernel for the past five (5) years. During that time we've
repeatedly encountered the same type of arguments for not including it,
and have provided proof as to why those arguments are not substantiated.
Lately I've at least got Andrew to admit that there were no maintenance
issues with the LTT trace statements (given that they've literally
remained unchanged ever since LTT was introduced.) In an effort to
address the issues regarding the usefulness of such a tool, I direct
those interested to this article on DTrace, a trace utility for Solaris:
http://www.theregister.co.uk/2004/07/08/dtrace_user_take/

<rant>
With LTT and DProbes, we've basically got almost everything this tool
claims to provide, save that we would be even further down the road if
we did not need to spend so much time updating patches ...
</rant>

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

