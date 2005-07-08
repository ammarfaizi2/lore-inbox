Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVGHEmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVGHEmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 00:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVGHEmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 00:42:10 -0400
Received: from effigent.net ([210.211.230.208]:27129 "EHLO effigent.net")
	by vger.kernel.org with ESMTP id S262603AbVGHEmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 00:42:07 -0400
Message-ID: <42CE031C.7030807@effigent.net>
Date: Fri, 08 Jul 2005 10:07:48 +0530
From: raja <vnagaraju@effigent.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: error func:
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
    I am writing a function that takes the return value of the another 
function and gives the  status of the function.
if
    error("functionName",arguments)
here the function with Name "functionName " is to be executed with the 
corresponding argunents.But by knowing the function name how can i get 
the address if that function and how can i execute the function with the 
arguments.

thanking you
